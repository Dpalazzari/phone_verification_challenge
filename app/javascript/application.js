// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"


const submitPhoneNumberButton = document.querySelector("#submit-phone-number");
const submitCodeButton = document.querySelector("#submit-verification-code");
const verificationCode = document.querySelector("#verification-code");
const phoneNumber = document.querySelector('#phone-number');
const phonePrimaryKey = document.querySelector('#phone-primary-key-id');

// Add event handler for when the 'Send Verification Code' button is clicked
submitPhoneNumberButton.onclick = () => { sendSMSPhoneVerification() };
// Add event handler for when the 'Verfy Code' button is clicked
submitCodeButton.onclick = () => {
  // TODO why wont this onclick event trigger?
  sendVerificationCode()
};
const sendSMSPhoneVerification = async () => {
  try {
    const payload = { phone: { number: phoneNumber.value } };
    const response = await postRequest(payload, '/api/v1/phone/verify');
    // Capture the Photo record's ID from the API response
    let phoneID = response.phone.id
    // Hide the phone number form, and reveal the verification code form
    document.querySelector('#phone-number').disabled = true
    document.querySelector('#phone-verify-fields').hidden = true;
    document.querySelector('#verify-your-phone').hidden = true;
    document.querySelector('#verify-code-fields').hidden = false;
    document.querySelector('#sms-sent').hidden = false;
    // Set the hidden phone primary key value to the supplied API ID in the response
    phonePrimaryKey.value = phoneID;
  } catch (error) {
    // Reset the form
    document.querySelector("#submit-phone-number").diabled = false;
    document.querySelector("#submit-verification-code").disabled = false;
    document.querySelector('#verify-your-phone').hidden = false;
    document.querySelector('#sms-sent').hidden = true;
    document.querySelector('#phone-verify-fields').hidden = false;
    document.querySelector('#verify-code-fields').hidden = true;
    alert(error);
  };
}

const sendVerificationCode = async () => {
  try {
    const payload = { verification_code: verificationCode.value }
    console.log(payload)
    const url = `/api/v1/phone/${phonePrimaryKey.value}/confirm_verification_code`
    const response = await postRequest(payload, url);
    // Hide both forms, indicate that the verification code was accepted
    document.querySelector('#phone-verify-fields').hidden = true;
    document.querySelector('#verify-code-fields').hidden = true;
    document.querySelector('#verify-your-phone').hidden = true;
    document.querySelector('#sms-sent').hidden = true;
    document.querySelector('#verification-successful').hidden = false;
  } catch (error) {
    alert(error);
  }
}

const postRequest = (payload, url) => {
  return new Promise((resolve, reject) => {
    fetch(url, {
      method: 'POST',
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify(payload)
    }).then(response => {
      resolve(response.json());
    }).catch(error => {
      reject(error);
    })
  });
}
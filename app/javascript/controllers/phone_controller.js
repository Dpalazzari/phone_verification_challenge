import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["number", "code"]
  static values = { id: Number }

  get number() {
    return this.numberTarget.value;
  }

  get code() {
    return this.codeTarget.value;
  }

  async sendSMSPhoneVerification() {
    try {
      // build the API request data
      const payload = { phone: { number: this.number } };
      const url = '/api/v1/phone/verify'
      const response = await this.postRequest(payload, url);
      console.log('RESPONSE', response);
      if (response.status === 200) {
        const data = await response.json();
        console.log('DATA', data);
        // Capture the Photo record's ID from the API response
        let phoneID = data.phone.id
        console.log(`PHONE ID: ${phoneID}`);
        document.querySelector('#phone-primary-key-id').value = phoneID;
        // Hide the phone number form, and reveal the verification code form
        document.querySelector('#phone-number').disabled = true
        document.querySelector('#phone-verify-fields').hidden = true;
        document.querySelector('#verify-your-phone').hidden = true;
        document.querySelector('#verify-code-fields').hidden = false;
        document.querySelector('#sms-sent').hidden = false;
        return true;
        // This response from the API indicates that this phone number has already been verified and
        // the verification has not expired
      } else if (response.status === 400) {
        const data = await response.json();
        if (data && data.message && data.message === 'Phone already verified') {
          alert('This phone is already verified.');
        }
      }
    } catch (error) {
      // Reset the form
      document.querySelector("#submit-phone-number").diabled = false;
      document.querySelector("#submit-verification-code").disabled = false;
      document.querySelector('#verify-your-phone').hidden = false;
      document.querySelector('#sms-sent').hidden = true;
      document.querySelector('#phone-verify-fields').hidden = false;
      document.querySelector('#verify-code-fields').hidden = true;
      alert(error);
    }
  }


  async sendVerificationCode() {
    try {
      const payload = { verification_code: this.code }
      const phoneID = document.querySelector('#phone-primary-key-id').value
      const url = `/api/v1/phone/${phoneID}/confirm_verification_code`
      const response = await this.postRequest(payload, url);
      console.log('RESPONSE', response);
      alert("Phone Successfully Verified!")
    } catch (error) {
      console.error(error)
    }
  }

  postRequest(payload, url) {
    return new Promise((resolve, reject) => {
      fetch(url, {
        method: 'POST',
        headers: {
          "Content-Type": "application/json"
        },
        body: JSON.stringify(payload)
      }).then(response => {
        resolve(response);
      }).catch(error => {
        reject(error);
      })
    });
  }
}

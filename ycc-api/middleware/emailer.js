const nodemailer = require('nodemailer');
const config = require('../config');l

const transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: 'nathan.ortbals@gmail.com',
    pass: 'Programming1!'
  }
});

const sendVerificationEmail = async function(email, key) {
  const mailOptions = {
    from: 'Youth Coalition of Columbia',
    to: email,
    subject: 'Please verify your account',
    text: config.address + '/api/auth/validate?key=' + key,
  };

  return transporter.sendMail(mailOptions);
};

module.exports = {
  sendVerificationEmail: sendVerificationEmail
};
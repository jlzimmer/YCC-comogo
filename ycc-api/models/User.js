const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const bcrypt = require('bcrypt');

const UserSchema = new Schema({
  email: {
    type: String,
    unique: true,
    required: true
  },
  password: {
    type: String,
    required: true
  },
  firstName: {
    type: String,
    required: true,
  },
  lastName: {
    type: String,
    required: true
  },
  phoneNumber: {
    type: String,
    required: false
  },
  validationKey: {
    type: Schema.Types.ObjectId,
    ref: 'ValidationKey'
  },
  attendingEvents: [{
    type: Schema.Types.ObjectId,
    ref: 'Event'
  }],
  hostingEvents: [{
    type: Schema.Types.ObjectId,
    ref: 'Event'
  }],
  role: {
    type: Schema.Types.ObjectId,
    ref: 'Role',
    required: true
  }
});

UserSchema.methods.getContactInfo = function() {
  return {
    firstName: this.firstName,
    lastName: this.lastName,
    phoneNumber: this.phoneNumber,
    email: this.email,
  }
};

UserSchema.methods.getAuthObject = function() {
  return {
    _id: this._id,
    firstName: this.firstName,
    lastName: this.lastName,
    phoneNumber: this.phoneNumber,
    email: this.email,
  }
};

UserSchema.methods.setRole = function(role) {
  role.users.pull(this);
  this.role = role;
  role.users.push(this);
};

UserSchema.methods.setValidationKey = function(validationKey) {
  this.validationKey = validationKey;
  validationKey.user = this;
};

UserSchema.pre('save', async function(next){

  //Hash the password with a salt round of 10
  //your application becomes.
  if(this.isNew){
    const hash = await bcrypt.hash(this.password, 10);
    //Replace the plain text password with the hash and then store it
    this.password = hash;
  }

  next();
});

UserSchema.methods.isValidPassword = async function(password){
  //Hashes the password sent by the user for login and checks if the hashed password stored in the
  //database matches the one sent. Returns true if it does else false.
  const compare = await bcrypt.compare(password, this.password);
  return compare;
};

module.exports = mongoose.model('User', UserSchema);

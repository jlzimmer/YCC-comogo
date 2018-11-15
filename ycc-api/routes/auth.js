const config = require('../config');
const express = require('express');
const jwt = require('jsonwebtoken');
const randomstring = require('randomstring');
const router = express.Router();
const User = require("../models/User");
const Role = require("../models/Role");
const ValidationKey = require("../models/ValidationKey");
const asyncWrapper = require("../middleware/asyncWrapper");
const validation = require("../validation/auth");
const emailer = require("../middleware/emailer");


/* REGISTER NEW USER */
router.post('/register', validation.postRegister, asyncWrapper(async function(req, res) {

  //Check if email already registered
  let user = await User.findOne({email: req.body.email});
  if(user){
    return res.status(400).json({error: "Email already registered"});
  }

  user = new User({
    email: req.body.email,
    firstName: req.body.firstName,
    lastName: req.body.lastName,
    password: req.body.password,
    phoneNumber: req.body.phoneNumber,
  });

  // Set Role to unverified
  let unverifiedRole = await Role.getUnverifiedRole();
  user.setRole(unverifiedRole);

  // Set validation key
  let validationKey = new ValidationKey({
    key: randomstring.generate()
  });
  user.setValidationKey(validationKey);



  // Save the user
  user = await user.save();
  unverifiedRole = await unverifiedRole.save();
  validationKey = await validationKey.save();
  await emailer.sendVerificationEmail(user.email, validationKey.key);

  return res.json(user.getAuthObject());
}));

/* LOGIN USER */
router.post('/login', validation.postLogin, asyncWrapper(async function(req, res) {

  const user = await User.findOne({email: req.body.email});

  if(!user) {
    return res.status(400).json({error: "Email not found"});
  }

  const isValidPassword = await user.isValidPassword(req.body.password);
  if(isValidPassword) {
    const token = jwt.sign(user.toJSON(), config.secret);
    res.json({token: 'JWT ' + token})
  } else {
    res.status(400).json({error: "Password incorrect"});
  }

}));

router.get('/validate', validation.getValidate, asyncWrapper(async function(req,res) {

  const validationKey = await ValidationKey.findOne({key: req.query.key});

  if(!validationKey) {
    return res.status(400).json({error: "Key not found"});
  }

  let user = await User.findById(validationKey.user);
  const userRole = await Role.getUserRole();

  user.setRole(userRole);

  await Promise.all([
    user.save(),
    userRole.save(),
    ValidationKey.findOne({key: req.params.key}).remove(),
  ]);

  return res.json({message: "success"});
}));

module.exports = router;
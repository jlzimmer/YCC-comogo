const schemaWrapper = require('./schemaWrapper');
const joi = require('joi');

const loginSchema = joi.object().keys({
  email: joi.string().email({ minDomainAtoms: 2 }).required(),
  password: joi.string().min(6).max(20).required(),
});

const registerSchema = joi.object().keys({
  email: joi.string().email({ minDomainAtoms: 2 }).required(),
  firstName: joi.string().alphanum().min(2).max(30).required(),
  lastName: joi.string().alphanum().min(2).max(30).required(),
  password: joi.string().min(6).max(20).required(),
  phoneNumber: joi.string().regex(/([0-9]{10})/).optional(),
});

const validateSchema = joi.object().keys({
  key: joi.string().required(),
});


module.exports =  {
  postLogin: schemaWrapper(loginSchema),
  postRegister: schemaWrapper(registerSchema),
  getValidate: schemaWrapper(validateSchema),
};
const joi = require('joi');

module.exports = (schema) => function(req, res, next) {

  let objectToValidate;
  if(req.method === "GET") {
    objectToValidate = req.query;
  }
  else {
    objectToValidate = req.body;
  }

  const validation = joi.validate(objectToValidate, schema);

  if(validation.error) {
    const error = validation.error.details[0].message;
    return res.status(400).json({error: error});
  }

  next();
};
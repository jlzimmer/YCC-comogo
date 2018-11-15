const schemaWrapper = require('./schemaWrapper');
const joi = require('joi');

const userSchema = joi.object().keys({
  _id: joi.string().alphanum().length(24).optional(),
});

module.exports = {
  getUser: schemaWrapper(userSchema),
};
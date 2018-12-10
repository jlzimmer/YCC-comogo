const schemaWrapper = require('./schemaWrapper');
const joi = require('joi');

const getLocationSchema = joi.object().keys({
  _id: joi.string().alphanum().length(24).optional(),
});

const postLocationSchema = joi.object().keys({
  title: joi.string().required(),
  addressLine1: joi.string().required(),
  addressLine2: joi.string().optional(),
  addressLine3: joi.string().required(),
});

const deleteLocationSchema = joi.object().keys({
  _id: joi.string().alphanum().length(24).required(),
});

module.exports = {
  getLocation: schemaWrapper(getLocationSchema),
  postLocation: schemaWrapper(postLocationSchema),
  deleteLocation: schemaWrapper(deleteLocationSchema),
};
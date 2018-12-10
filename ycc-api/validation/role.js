const schemaWrapper = require('./schemaWrapper');
const joi = require('joi');

const getRoleSchema = joi.object().keys({
  _id: joi.string().alphanum().length(24).optional(),
});

const postRoleSchema = joi.object().keys({
  title: joi.string().required(),
});

const deleteRoleSchema = joi.object().keys({
  _id: joi.string().alphanum().length(24).required(),
});

module.exports = {
  getRole: schemaWrapper(getRoleSchema),
  postRole: schemaWrapper(postRoleSchema),
  deleteRole: schemaWrapper(deleteRoleSchema),
};

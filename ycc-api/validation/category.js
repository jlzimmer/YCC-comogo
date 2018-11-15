const schemaWrapper = require('./schemaWrapper');
const joi = require('joi');

const getCategorySchema = joi.object().keys({
  _id: joi.string().alphanum().length(24).optional(),
});

const postCategorySchema = joi.object().keys({
  title: joi.string().required(),
});

const deleteCategorySchema = joi.object().keys({
  _id: joi.string().alphanum().length(24).required(),
});

module.exports = {
  getCategory: schemaWrapper(getCategorySchema),
  postCategory: schemaWrapper(postCategorySchema),
  deleteCategory: schemaWrapper(deleteCategorySchema),
};
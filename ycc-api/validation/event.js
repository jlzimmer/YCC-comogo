const schemaWrapper = require('./schemaWrapper');
const joi = require('joi');

const getEventSchema = joi.object().keys({
  _id: joi.string().alphanum().length(24).required()
});

const postEventSchema = joi.object().keys({
  title: joi.string().required(),
  description: joi.string().required(),
  image: joi.binary().optional(),
  start: joi.date().timestamp().required(),
  end: joi.date().timestamp().required(),
  url: joi.string().regex(/^(?:(?:(?:https?|ftp):)?\/\/)(?:\S+(?::\S*)?@)?(?:(?!(?:10|127)(?:\.\d{1,3}){3})(?!(?:169\.254|192\.168)(?:\.\d{1,3}){2})(?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-z0-9\u00a1-\uffff][a-z0-9\u00a1-\uffff_-]{0,62})?[a-z0-9\u00a1-\uffff]\.)+(?:[a-z\u00a1-\uffff]{2,}\.?))(?::\d{2,5})?(?:[/?#]\S*)?$/i)
    .optional(),
  hostUser: joi.string().alphanum().length(24).required(),
  category: joi.string().alphanum().length(24).required(),
  location: joi.string().alphanum().length(24).required(),
});

const deleteEventSchema = joi.object().keys({
  _id: joi.string().alphanum().length(24).required(),
});

module.exports = {
  getEvent: schemaWrapper(getEventSchema),
  postEvent: schemaWrapper(postEventSchema),
  deleteEvent: schemaWrapper(deleteEventSchema),
};
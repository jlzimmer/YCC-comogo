const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const User = require('./User');
const Category = require('./Category');
const Location = require('./Location');

const EventSchema = new mongoose.Schema({
  title: {
    type: String,
    required: true,
  },
  description: {
    type: String,
    required: true,
  },
  image: {
    data: Buffer,
    contentType: String,
    required: false,
  },
  start: {
    type: Date,
    required: true,
  },
  end: {
    type: Date,
    required: true,
  },
  posted: {
    type: Date,
    required: true,
  },
  url: {
    type: String,
    required: false
  },
  hostUser: {
    type: Schema.Types.ObjectId,
    ref: 'User',
    required: true,
  },
  category: {
    type: Schema.Types.ObjectId,
    ref: 'Category',
    required: true,
  },
  location: {
    type: Schema.Types.ObjectId,
    ref: 'Location',
    required: true,
  },
  attendingUsers: [{
    type: Schema.Types.ObjectId,
    ref: 'User',
  }],
});

EventSchema.methods.getReturnObject = function() {
  return {
    _id: this._id,
    title: this.title,
    description: this.description,
    image: this.image,
    start: this.start,
    end: this.end,
    posted: this.posted,
    url: this.url,
    hostUser: this.hostUser._id,
    category: this.category._id,
    location: this.location._id
  };
};


EventSchema.methods.setHostUser = function(user) {

  this.hostUser = user;
  user.hostingEvents.push(this);

  return user;
};

EventSchema.methods.setCategory = function(category) {

  this.category = category;
  category.events.push(this);

  return category;
};

EventSchema.methods.setLocation = function(location) {

  this.location = location;
  location.events.push(this);

  return location;
};

module.exports = mongoose.model('Event', EventSchema);
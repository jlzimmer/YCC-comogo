const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const LocationSchema = new Schema({
  title: {
    type: String,
    required: true
  },
  addressLine1: {
    type: String,
    required: true
  },
  addressLine2: {
    type: String,
    required: false
  },
  addressLine3: {
    type: String,
    required: true
  },
  events: [{
    type: Schema.Types.ObjectId,
    ref: 'Event'
  }],
});

module.exports = mongoose.model('Location', LocationSchema);
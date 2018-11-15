const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const ValidationKey = new Schema({
  key: {
    type: String,
    unique: true,
    required: true
  },
  user: {
    type: Schema.Types.ObjectId,
    ref: 'User',
    required: true,
  },
});

module.exports = mongoose.model('ValidationKey', ValidationKey);
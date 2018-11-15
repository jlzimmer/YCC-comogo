const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const CategorySchema = new Schema({
  title: {
    type: String,
    unique: true,
    required: true
  },
  events: [{
    type: Schema.Types.ObjectId,
    ref: 'Event'
  }],
});

module.exports = mongoose.model('Category', CategorySchema);
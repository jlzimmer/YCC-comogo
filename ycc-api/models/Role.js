const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const RoleSchema = new Schema({
  title: {
    type: String,
    unique: true,
    required: true
  },
  users: [{
    type: Schema.Types.ObjectId,
    ref: 'User'
  }],
});

RoleSchema.statics.getUnverifiedRole = async function() {
  let role = await this.findOne({title: "Unverified"});

  if(!role) {
    const newRole = new this({
      title: "Unverified"
    });

    role = await newRole.save();
  }

  return role;
};

RoleSchema.statics.getUserRole = async function() {
  let role = await this.findOne({title: "User"});

  if(!role) {
    const newRole = new this({
      title: "User"
    });

    role = await newRole.save();
  }

  return role;
};

RoleSchema.statics.getAdminRole = async function() {
  let role = await this.findOne({title: "Admin"});

  if(!role) {
    const newRole = new this({
      title: "Admin"
    });

    role = await newRole.save();
  }

  return role;
};

RoleSchema.statics.getSuperAdminRole = async function() {
  let role = await this.findOne({title: "Super Admin"});

  if(!role) {
    const newRole = new this({
      title: "Super Admin"
    });

    role = await newRole.save();
  }

  return role;
};

module.exports = mongoose.model('Role', RoleSchema);
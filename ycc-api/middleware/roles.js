const User = require('../models/User.js');
const Role = require('../models/Role');

let unverifiedRole;
let userRole;
let adminRole;
let superAdminRole;

async function getRoles() {

  [unverifiedRole, userRole, adminRole, superAdminRole] = await Promise.all([
    Role.getUnverifiedRole(),
    Role.getUserRole(),
    Role.getAdminRole(),
    Role.getSuperAdminRole()
  ]);

  if(!unverifiedRole || !userRole || !adminRole || !superAdminRole) {
    throw Error("Roles not found");
  }
}

async function verifyUser(req, res, next) {
  await getRoles();

  if(req.user.role._id.equals(userRole._id) || req.user.role._id.equals(adminRole._id)) {
    next();
  }
  else {
    return res.status(401).json({error: "Unauthorized, must be user role"});
  }
}

async function verifyAdmin(req, res, next) {
  await getRoles();

  if(req.user.role._id.equals(adminRole._id) || req.user.role._id.equals(superAdminRole._id)) {
    next();
  }
  else {
    return res.status(401).json({error: "Unauthorized, must be admin role"});
  }
}

async function verifySuperAdmin(req, res, next) {
  await getRoles();

  if(req.user.role._id.equals(superAdminRole._id)) {
    next();
  }
  else {
    return res.status(401).json({error: "Unauthorized, must be super admin role"});
  }
}


module.exports = {verifyUser, verifyAdmin, verifySuperAdmin};


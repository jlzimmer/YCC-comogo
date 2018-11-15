const express = require('express');
const router = express.Router();
const Role = require('../models/Role.js');
const roles = require('../middleware/roles');
const validation = require('../validation/role');
const asyncWrapper = require('../middleware/asyncWrapper');
const validateToken = require('../middleware/passport').validateToken;

/* GET ROLE(S) */
router.get('/', validateToken, roles.verifyUser, validation.getRole,
  asyncWrapper(async function(req, res) {
    const roles = await Role.find(req.query);

    if(req.query._id && roles.length == 0) {
      return res.status(404).json({error: "Role not found"});
    }

    res.json(roles);
}));

/* SAVE ROLE */
router.post('/', validateToken, roles.verifySuperAdmin, validation.postRole,
  asyncWrapper(async function(req, res) {

    const role = await Role.create(req.body)
    res.json(role);
}));

/* DELETE ROLE */
router.delete('/', validateToken, roles.verifySuperAdmin, validation.deleteRole,
  asyncWrapper(async function(req, res) {
    const role = await Role.findByIdAndRemove(req.query._id);

    if(!role) {
      return res.status(404).json({error: "Role not found"});
    }

    res.json({message: "success"});
}));

module.exports = router;
const express = require('express');
const router = express.Router();
const User = require('../models/User.js');
const roles = require('../middleware/roles');
const validation = require("../validation/user");
const asyncWrapper = require("../middleware/asyncWrapper");
const validateToken = require('../middleware/passport').validateToken;

/* GET USER CONTACT INFO */
router.get('/', validateToken, roles.verifyUser, validation.getUser,
  asyncWrapper(async function(req, res) {

    let user;
    if(req.query._id) {
      user = await User.findById(req.query._id);

      if(!user) {
        return res.status(400).json({error: "User not found"});
      }

      const contactInfo = user.getContactInfo();
      return res.json(contactInfo);
    }

    return res.json(req.user);
}));

module.exports = router;
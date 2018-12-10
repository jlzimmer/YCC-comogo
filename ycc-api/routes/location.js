const express = require('express');
const router = express.Router();
const Location = require('../models/Location.js');
const roles = require('../middleware/roles');
const validation = require('../validation/location');
const asyncWrapper = require('../middleware/asyncWrapper');
const validateToken = require('../middleware/passport').validateToken;

/* GET LOCATION(S) */
router.get('/', validateToken, roles.verifyUser, validation.getLocation,
  asyncWrapper(async function(req, res) {
    const locations = await Location.find(req.query);

    if(req.query._id && locations.length == 0) {
      return res.status(404).json({error: "Location not found"});
    }

    res.json(locations);
}));

/* SAVE LOCATION */
router.post('/', validateToken, roles.verifyAdmin, validation.postLocation,
  asyncWrapper(async function(req, res) {

    const location = await Location.create(req.body);
    res.json(location);
}));

/* DELETE LOCATION */
router.delete('/', validateToken, roles.verifyAdmin, validation.deleteLocation,
  asyncWrapper(async function(req, res) {
    const location = await Location.findByIdAndRemove(req.query._id);

    if(!location) {
      return res.status(404).json({error: "Location not found"});
    }

    res.json({message: "success"});
}));

module.exports = router;
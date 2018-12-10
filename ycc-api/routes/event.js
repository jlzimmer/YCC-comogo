const express = require('express');
const router = express.Router();
const Event = require('../models/Event');
const User = require('../models/User');
const Category = require('../models/Category');
const Location = require('../models/Location');
const asyncWrapper = require('../middleware/asyncWrapper');
const roles = require('../middleware/roles');
const validation = require('../validation/event');
const validateToken = require('../middleware/passport').validateToken;

/* GET EVENT(S) */
router.get('/', validateToken, roles.verifyUser, validation.getEvent,
  asyncWrapper(async function(req, res) {

    const event = await Event.findById(req.query._id);

    if(!event) {
      return res.status(404).json({error: "Event not found"});
    }

    res.json(event);
}));

/* SAVE EVENT */
router.post('/', validateToken, roles.verifyAdmin, validation.postEvent,
  asyncWrapper(async function(req, res) {

    let event = new Event({
      title: req.body.title,
      description: req.body.description,
      image: req.body.image,
      start: req.body.start,
      end: req.body.end,
      url: req.body.url,
      posted: Date.now(),
    });

    let [hostUser, category, location] = await Promise.all([
      User.findById(req.body.hostUser),
      Category.findById(req.body.category),
      Location.findById(req.body.location),
    ]);

    if(hostUser == null) {
      return res.status(400).send({error: "Host user not found"});
    }
    if(category == null) {
      return res.status(400).send({error: "Category not found"});
    }
    if(location == null) {
      return res.status(400).send({error: "Location not found"});
    }

    event.setHostUser(hostUser);
    event.setCategory(category);
    event.setLocation(location);

    [hostUser, category, location, event] = await Promise.all([
      hostUser.save(),
      category.save(),
      location.save(),
      event.save()
    ]);

    res.json(event.getReturnObject());
}));

/* DELETE EVENT */
router.delete('/', validateToken, roles.verifyAdmin, validation.deleteEvent,
  asyncWrapper(async function(req, res) {

    const event = await Event.findByIdAndRemove(req.query._id);

    if(!event) {
      return res.status(404).json({error: "Event not found"});
    }

    await Event.remove(req.body);
    res.json({message: "success"});
}));

module.exports = router;
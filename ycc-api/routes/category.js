const express = require('express');
const router = express.Router();
const Category = require('../models/Category');
const roles = require('../middleware/roles');
const validateToken = require('../middleware/passport').validateToken;
const validation = require('../validation/category');
const asyncWrapper = require('../middleware/asyncWrapper');

/* GET CATEGORY(S) */
router.get('/', validateToken, roles.verifyUser, validation.getCategory,
  asyncWrapper(async function(req, res) {
    const categories = await Category.find(req.query);

    if(req.query._id && categories.length == 0) {
      return res.status(404).json({error: "Category not found"});
    }

    res.json(categories);
}));

/* SAVE CATEGORY */
router.post('/', validateToken, roles.verifyAdmin, validation.postCategory,
  asyncWrapper(async function(req, res) {
    let category = await Category.findOne(req.body);

    if(category) {
      return res.status(400).json({error: "Category title already exists"});
    }

    category = await Category.create(req.body);
    res.json(category);
}));

/* DELETE CATEGORY */
router.delete('/', validateToken, roles.verifyAdmin, validation.deleteCategory,
  asyncWrapper(async function(req, res) {
    const category = await Category.findByIdAndRemove(req.query._id);

    if(!category)
        return res.status(404).json({error: "Category not found"});

    res.json({message: "success"});
}));

module.exports = router;
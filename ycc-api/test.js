const mongoose = require('mongoose');
const config = require('./config');
const User = require("./models/User");
const Role = require('./models/Role');
const emailer = require('./middleware/emailer');

mongoose.promise = global.Promise; //Configure mongoose's promise to global promise
mongoose.connect(config.mongoDbAddress);
mongoose.set('debug', true);


User.findById('5bea196d648ec961bd73779e').then(function(user, err) {
    Role.getAdminRole().then(function(role, err) {
        user.setRole(role);

        Promise.all([
          user.save(),
          role.save(),
        ]).then(function(results, err) {
            console.log();
        })
    })
});

//emailer.sendVerificationEmail('nathan.ortbals@gmail.com', 'test');


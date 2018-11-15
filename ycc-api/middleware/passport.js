const JwtStrategy = require('passport-jwt').Strategy;
const ExtractJwt = require('passport-jwt').ExtractJwt;
const passport = require('passport');
const User = require('../models/User');
const config = require('../config');

// Strategy config
const passportConfig = function() {

  const opts = {
    jwtFromRequest: ExtractJwt.fromAuthHeaderWithScheme("jwt"),
    secretOrKey: config.passportSecret
  };

  passport.use(new JwtStrategy(opts, function(jwt_payload, done) {
    User.findById(jwt_payload._id, function(err, user) {
      if (err) {
        return done(err, false);
      }

      if (user) {
        done(null, user);
      } else {
        done(null, false);
      }
    });
  }));
};

// Middleware function
const validateToken = function(req, res, next){
  passport.authenticate('jwt', { session: false }, function(err, user, info) {
    if (err) {
      throw err;
    }

    if(!user) {
      return res.status(403).json({error: info.message});
    }

    req.user = user;
    next();

  })(req, res, next);
};

module.exports = {
  passportConfig: passportConfig,
  validateToken: validateToken
};
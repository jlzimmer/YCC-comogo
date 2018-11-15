const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const mongoose = require('mongoose');
const passport = require('./middleware/passport');
const config = require('./config');

//Initiate express server
const app = express();

//Configure expresss server
app.use(cors());
app.use(require('morgan')('dev'));
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

// Routes
const auth = require('./routes/auth');
const category = require('./routes/category');
const event = require('./routes/event');
const location = require('./routes/location');
const role = require('./routes/role');
const user = require('./routes/user');

app.use('/api/auth', auth);
app.use('/api/category', category);
app.use('/api/event', event);
app.use('/api/location', location);
app.use('/api/role', role);
app.use('/api/user', user);

//Error handler
app.use((err, req, res, next) => {
  res.status(500).json({
    error: err.message
  });
});

//Configure passport
passport.passportConfig();

//Configure Mongoose
mongoose.promise = global.Promise; //Configure mongoose's promise to global promise
mongoose.connect(config.mongoDbAddress);
mongoose.set('debug', true);


app.listen(config.port, () => console.log('Server running on port ' + config.port));

module.exports = function (config) {
    config.set({
      frameworks: ['jasmine', '@angular-devkit/build-angular'], // Ensure both Jasmine and Angular are included
      plugins: [
        require('karma-jasmine'),
        require('karma-chrome-launcher'),
        require('karma-coverage'),
        require('@angular-devkit/build-angular/plugins/karma')
      ],
      reporters: ['progress', 'coverage'],
      browsers: ['ChromeHeadless'],
      singleRun: true,
      coverageReporter: {
        type: 'lcov',
        dir: 'coverage/',
        subdir: '.'
      }
    });
  };
  
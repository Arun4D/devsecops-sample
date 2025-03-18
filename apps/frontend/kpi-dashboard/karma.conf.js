module.exports = function (config) {
  config.set({
    basePath: '',
    frameworks: ['jasmine', '@angular-devkit/build-angular'],
    plugins: [
      require('karma-jasmine'),
      require('karma-chrome-launcher'),
      require('karma-jasmine-html-reporter'),
      require('karma-coverage'),
      require('@angular-devkit/build-angular/plugins/karma')
    ],
    client: {
      clearContext: false // Keep test results visible in the browser
    },
    coverageReporter: {
      type: 'lcov',
      dir: require('path').join(__dirname, 'coverage'),
      subdir: '.'
    },
    reporters: ['progress', 'kjhtml'],
    port: 9876,
    colors: true,
    logLevel: config.LOG_INFO,
    restartOnFileChange: true,
    browsers: ['ChromeHeadless'],
    singleRun: true, // Ensures tests exit after running
    autoWatch: false, // Prevents watching files (avoids hanging)
    captureTimeout: 60000, // Stops tests if browser doesn't connect in 60s
    browserDisconnectTimeout: 10000, // If a browser disconnects, wait 10s before retrying
    browserNoActivityTimeout: 30000, // Stop tests if no activity for 30s
  });
};


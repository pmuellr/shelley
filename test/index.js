// Generated by CoffeeScript 1.3.3
(function() {
  var currentWindowOnload, execJasmine, jasmineEnv, trivialReporter;

  window.localStorage.clear();

  jasmineEnv = jasmine.getEnv();

  jasmineEnv.updateInterval = 1000;

  trivialReporter = new jasmine.TrivialReporter();

  jasmineEnv.addReporter(trivialReporter);

  jasmineEnv.specFilter = function(spec) {
    return trivialReporter.specFilter(spec);
  };

  currentWindowOnload = window.onload;

  window.onload = function() {
    if (currentWindowOnload) {
      currentWindowOnload();
    }
    return execJasmine();
  };

  execJasmine = function() {
    return jasmineEnv.execute();
  };

}).call(this);

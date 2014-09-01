var controllers = {};

controllers.simpleController = function ($scope){
  $scope.customers = [
    { name: "John", city: "Phoenix"},
    { name: "Jane", city: "Seattle"},
    { name: "Micheal", city: "Chandler"},
    { name: "Dave", city: "Phoenix"}
  ];

  $scope.addCustomer = function(){
    console.log($scope.newCustomer);
    $scope.customers.push(
        {name: $scope.newCustomer.name, city: $scope.newCustomer.city}
      );
  };
};

var myApp = angular.module('myApp', ['ngRoute']);
myApp.controller(controllers);

myApp.config(function($routeProvider){
  $routeProvider
  .when('/',
        {
          controller: 'simpleController',
          templateUrl: 'view1.html'
        })
  .when('/view2',
      {
        controller: 'simpleController',
        templateUrl: 'view2.html'
      })
  .when('/view1',
      {
        controller: 'simpleController',
        templateUrl: 'view1.html'
      });
});

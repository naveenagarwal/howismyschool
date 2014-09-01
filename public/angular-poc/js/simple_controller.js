var myApp = angular.module('myApp', ['ngRoute', 'ngResource']);

var simpleController = function ($scope, $routeParams, Comments){
  $scope.customers = [
    { name: "John", city: "Phoenix"},
    { name: "Jane", city: "Seattle"},
    { name: "Micheal", city: "Chandler"},
    { name: "Dave", city: "Phoenix"}
  ];

  $scope.addCustomer = function(){
    $scope.customers.push(
        {name: $scope.newCustomer.name, city: $scope.newCustomer.city}
      );
  };

  comments = Comments;
};

var simpleController1 = function($scope){

};

myApp.factory('Comments', ['$resource', function($resource){
  return $resource("/comments/:id", { id: "@id" }, {
    'update': { method: 'PUT', params: {id: "@id"}}
  });
}]);

myApp.config(['$routeProvider',function($routeProvider){
  $routeProvider
  .when('/',
        {
          controller: 'simpleController',
          templateUrl: 'view1.html'
        })
  .when('/view2',
      {
        controller: 'simpleController1',
        templateUrl: 'view2.html'
      })
  .when('/view1',
      {
        controller: 'simpleController',
        templateUrl: 'view1.html'
      });
}]);

myApp.controller('simpleController', ['$scope', '$routeParams', 'Comments', simpleController]);
myApp.controller('simpleController1', ['$scope', simpleController1]);

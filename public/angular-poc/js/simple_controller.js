var myApp = angular.module('myApp', ['ngRoute', 'ngResource']);

var simpleController = function ($scope, Comments){
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

var simpleController1 = function($scope, Comments){
  $scope.hideNewForm = false;
  $scope.hideEditForm = true;
  $scope.comments = Comments.query();

  $scope.addComment = function(){
    var comment = { description: $scope.newComment.description };
    Comments.save(comment, function(){
      $scope.comments = Comments.query();
      $scope.newComment.description = "";
    });
  };

  $scope.removeComment = function(id){
    Comments.remove({ id: id}, function(){
      $scope.comments = Comments.query();
    });
  }

  $scope.updateComment = function(id){
    var comment = { description: $scope.editComment.description }
    Comments.update({ id: id, comment: comment }, function(){
      $scope.comments = Comments.query();
    });
  }

  $scope.editComment = function(id){
    Comments.get({ id: id}, function(comment){
      $scope.hideNewForm = true;
      $scope.hideEditForm = false;
      $scope.editComment.description = comment.description;
      $scope.editComment.id = id;
    });
  }

  $scope.newComment = function(){
    $scope.hideNewForm = false;
    $scope.hideEditForm = true;
    $scope.newComment.description = "";
  }

  $scope.hideThisForm = true;
};
myApp.filter('formatDate', function($filter){
  return function(input){
    if(input == null){ return ""; }
    var date = $filter('date')(new Date(input), 'MMM dd yyyy');
    return date.toUpperCase();
   };
});

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
      })
  .when('/edit_comment/:id',
      {
        controller: 'simpleController1',
        templateUrl: 'view3.html'
      });
}]);

myApp.controller('simpleController', ['$scope', 'Comments', simpleController]);
myApp.controller('simpleController1', ['$scope', 'Comments', simpleController1]);

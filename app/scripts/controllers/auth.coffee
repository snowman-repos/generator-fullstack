'use strict'

angular.module('iproferoApp')
	.controller 'AuthCtrl', ['$scope', 'Auth', '$location', '$notification', ($scope, Auth, $location, $notification) ->
		$scope.error = {}
		$scope.user = {}
		$scope.login = (form) ->
			$notification.enableHtml5Mode()
			Auth.login "password",
				email: $scope.user.email
				password: $scope.user.password
			, (err) ->
				$scope.errors = {}
				unless err
					$location.path "/"
				else
					angular.forEach err.errors, (error, field) ->
						form[field].$setValidity "mongoose", false
						$scope.errors[field] = error.type

					$scope.error.other = err.message

		$scope.register = (form) ->
			$notification.enableHtml5Mode()
			Auth.createUser
				email: $scope.user.email
				username: $scope.user.username
				password: $scope.user.password
			, (err) ->
				$scope.errors = {}
				unless err
					$location.path "/"
				else
					angular.forEach err.errors, (error, field) ->
						form[field].$setValidity "mongoose", false
						$scope.errors[field] = error.type
	]
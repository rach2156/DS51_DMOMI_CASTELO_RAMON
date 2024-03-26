<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\ConsultController;
use App\Http\Controllers\Api\CustomerController;
use App\Http\Controllers\Api\PetController;
use App\Http\Controllers\Api\UserController;
use App\Http\Controllers\AuthController;


Route::get('/consults', [ConsultController::class, 'list']);
Route::get('/consults/{id}', [ConsultController::class, 'item']);
Route::post('/consults/create', [ConsultController::class, 'create']);
Route::post('/consults/{id}', [ConsultController::class, 'update']);


Route::get('/customers', [CustomerController::class, 'list']);
Route::get('/customers/{id}', [CustomerController::class, 'item']);
Route::post('/customers/create', [CustomerController::class, 'create']);
Route::post('/customers/update', [CustomerController::class, 'update']);

Route::get('/pets', [PetController::class, 'list']);
Route::get('/pets/{id}', [PetController::class, 'item']);
Route::post('/pets/create', [PetController::class, 'create']);
Route::post('/pets/{id}', [PetController::class, 'update']);

Route::get('/users', [UserController::class, 'list']);
Route::get('/users/{id}', [UserController::class, 'item']);
Route::post('/users/create', [UserController::class, 'create']);
Route::post('/users/{id}', [UserController::class, 'update']);


Route::post('login', [AuthController::class, 'login']);
Route::post('logout', [AuthController::class, 'logout']);


Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
return $request->user();

});





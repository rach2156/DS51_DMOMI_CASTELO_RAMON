<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Pet;
use Illuminate\Http\Request;

class PetController extends Controller
{
    public function list()
    {
        $pets = Pet::all();
        $list = [];

        foreach ($pets as $pet) {
            $object = [
                "id" => $pet->id,
                "nombre" => $pet->nombre,
                "tipo" => $pet->tipo,
                "raza" => $pet->raza,
                "edad" => $pet->edad,
                "cliente_id" => $pet->cliente_id,
                "created" => $pet->created_at,
                "updated" => $pet->updated_at
            ];

            array_push($list, $object);
        }

        return response()->json($list);
    }

    public function item($id)
    {
        $pet = Pet::find($id);

        if (!$pet) {
            return response()->json(["error" => "Pet not found"], 404);
        }

        $object = [
            "id" => $pet->id,
            "nombre" => $pet->nombre,
            "tipo" => $pet->tipo,
            "raza" => $pet->raza,
            "edad" => $pet->edad,
            "cliente_id" => $pet->cliente_id,
            "created" => $pet->created_at,
            "updated" => $pet->updated_at
        ];

        return response()->json($object);
    }

    public function create(Request $request)
    {
        $data = $request->validate([
            'nombre' => 'required',
            'tipo' => 'required',
            'raza' => 'required',
            'edad' => 'required',
            'cliente_id' => 'required'
        ]);

        $pet = Pet::create([
            'nombre' => $data['nombre'],
            'tipo' => $data['tipo'],
            'raza' => $data['raza'],
            'edad' => $data['edad'],
            'cliente_id' => $data['cliente_id']
        ]);

        if ($pet) {
            return response()->json([
                "response" => 'Success. Item saved correctly.',
                "data" => $pet,
            ]);
        } else {
            return response()->json([
                "response" => 'Error: Something went wrong, please try again.',
            ]);
        }
    }

    public function update(Request $request, $id)
    {
        $data = $request->validate([
            'nombre' => 'required',
            'tipo' => 'required',
            'raza' => 'required',
            'edad' => 'required',
            'cliente_id' => 'required'
        ]);

        $pet = Pet::find($id);

        if (!$pet) {
            return response()->json(["error" => "Pet not found"], 404);
        }

        $old = $pet->toArray();

        $pet->update($data);

        return response()->json([
            "response" => 'Success. Item updated successfully.',
            "data" => $pet,
            "old" => $old
        ]);
    }
}

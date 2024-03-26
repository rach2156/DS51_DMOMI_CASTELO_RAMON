<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Consult;
use Illuminate\Http\Request;

class ConsultController extends Controller
{
    public function list()
    {
        $consults = Consult::all();
        $list = [];

        foreach ($consults as $consult) {
            $object = [
                "id" => $consult->id,
                "fecha" => $consult->fecha,
                "motivo" => $consult->motivo,
                "diagnostico" => $consult->diagnostico,
                "tratamiento" => $consult->tratamiento,
                "mascota_id" => $consult->mascota_id,
                "created" => $consult->created_at,
                "updated" => $consult->updated_at
            ];

            array_push($list, $object);
        }

        return response()->json($list);
    }

    public function item($id)
    {
        $consult = Consult::find($id);

        if (!$consult) {
            return response()->json(["error" => "Consult not found"], 404);
        }

        $object = [
            "id" => $consult->id,
            "fecha" => $consult->fecha,
            "motivo" => $consult->motivo,
            "diagnostico" => $consult->diagnostico,
            "tratamiento" => $consult->tratamiento,
            "mascota_id" => $consult->mascota_id,
            "created" => $consult->created_at,
            "updated" => $consult->updated_at
        ];

        return response()->json($object);
    }

    public function create(Request $request)
    {
        $data = $request->validate([
            'fecha' => 'required',
            'motivo' => 'required',
            'diagnostico' => 'required',
            'tratamiento' => 'required',
            'mascota_id' => 'required'
        ]);

        $consult = Consult::create([
            'fecha' => $data['fecha'],
            'motivo' => $data['motivo'],
            'diagnostico' => $data['diagnostico'],
            'tratamiento' => $data['tratamiento'],
            'mascota_id' => $data['mascota_id'],
        ]);

        if ($consult) {
            return response()->json([
                "response" => 'Success. Item saved correctly.',
                "data" => $consult,
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
            'fecha' => 'required',
            'motivo' => 'required',
            'diagnostico' => 'required',
            'tratamiento' => 'required',
            'mascota_id' => 'required'
        ]);

        $consult = Consult::find($id);

        if (!$consult) {
            return response()->json(["error" => "Consult not found"], 404);
        }

        $consult->update($data);

        return response()->json([
            "response" => 'Success. Item updated successfully.',
            "data" => $consult
        ]);
    }
}

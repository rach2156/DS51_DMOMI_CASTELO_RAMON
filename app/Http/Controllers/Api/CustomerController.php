<?php

nameSpace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Customer;
use Illuminate\Http\Request;

class CustomerController extends Controller
{
    public function list()
    {
        $customers = Customer::all();
        $list = [];

        foreach ($customers as $customer) {
            $object = [
                "id" => $customer->id,
                "nombre" => $customer->nombre,
                "telefono" => $customer->telefono,
                "email" => $customer->email,
                "direccion" => $customer->direccion,
                "created" => $customer->created_at,
                "updated" => $customer->updated_at
            ];

            array_push($list, $object);
        }

        return response()->json($list);
    }

    public function item($id)
    {
        $customer = Customer::find($id);

        if (!$customer) {
            return response()->json(["error" => "Customer not found"], 404);
        }

        $object = [
            "id" => $customer->id,
            "nombre" => $customer->nombre,
            "telefono" => $customer->telefono,
            "email" => $customer->email,
            "direccion" => $customer->direccion,
            "created" => $customer->created_at,
            "updated" => $customer->updated_at
        ];

        return response()->json($object);
    }

    public function create(Request $request)
    {
        $data = $request->validate([
            'nombre' => 'required',
            'telefono' => 'required',
            'email' => 'required',
            'direccion' => 'required'
        ]);

        $customer = Customer::create([
            'nombre' => $data['nombre'],
            'telefono' => $data['telefono'],
            'email' => $data['email'],
            'direccion' => $data['direccion']
        ]);

        if ($customer) {
            return response()->json([
                "response" => 'Success. Item saved correctly.',
                "data" => $customer,
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
            'id' => 'required',
            'nombre' => 'required',
            'telefono' => 'required',
            'email' => 'required',
            'direccion' => 'required'
        ]);

        $customer = Customer::find($id);

        if (!$customer) {
            return response()->json(["error" => "Customer not found"], 404);
        }

        $old = $customer->toArray();

        $customer->update($data);

        return response()->json([
            "response" => 'Success. Item updated successfully.',
            "data" => $customer,
            "old" => $old
        ]);
    }
}

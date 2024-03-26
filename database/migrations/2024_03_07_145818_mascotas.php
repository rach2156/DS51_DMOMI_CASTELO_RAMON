<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
{
    Schema::create('mascotas', function (Blueprint $table) {
        $table->id();
        $table->string('nombre');
        $table->string('tipo');
        $table->string('raza');
        $table->integer('edad');
        $table->unsignedBigInteger('cliente_id');
        $table->foreign('cliente_id')->references('id')->on('clientes');
        $table->timestamps();
    });
}

    public function down(): void
    {
        //
    }
};

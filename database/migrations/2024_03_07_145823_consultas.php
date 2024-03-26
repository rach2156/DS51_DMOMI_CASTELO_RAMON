<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
{
    Schema::create('consultas', function (Blueprint $table) {
        $table->id();
        $table->date('fecha');
        $table->string('motivo');
        $table->string('diagnostico');
        $table->string('tratamiento');
        $table->unsignedBigInteger('mascota_id');
        $table->foreign('mascota_id')->references('id')->on('mascotas');
        $table->timestamps();
    });
}
    public function down(): void
    {
        //
    }
};

import tkinter as tk
from tkinter import messagebox, Listbox, Scrollbar
import mysql.connector
import datetime

# Conectar a la base de datos
def conectar_db():
    try:
        conexion = mysql.connector.connect(
            host="localhost",
            user="root",
            password="",
            database="gestion_gastos"
        )
        return conexion
    except mysql.connector.Error as e:
        messagebox.showerror("Error", f"No se pudo conectar a la base de datos: {e}")
        return None

# Función para registrar usuarios
def registrar_usuario():
    nombre = nombre_entry.get()
    apellido = apellido_entry.get()
    correo = correo_entry.get()
    contraseña = contraseña_entry.get()

    if nombre and apellido and correo and contraseña:
        conexion = conectar_db()
        if conexion:
            try:
                cursor = conexion.cursor()
                query = "INSERT INTO usuarios (nombre, apellido, correo, contraseña) VALUES (%s, %s, %s, %s)"
                cursor.execute(query, (nombre, apellido, correo, contraseña))
                conexion.commit()
                messagebox.showinfo("Éxito", "Usuario registrado correctamente")
                limpiar_campos_usuario()
            except mysql.connector.Error as e:
                messagebox.showerror("Error", f"Error al registrar usuario: {e}")
            finally:
                cursor.close()
                conexion.close()
    else:
        messagebox.showwarning("Advertencia", "Por favor, completa todos los campos")

def limpiar_campos_usuario():
    nombre_entry.delete(0, tk.END)
    apellido_entry.delete(0, tk.END)
    correo_entry.delete(0, tk.END)
    contraseña_entry.delete(0, tk.END)

# Función para registrar gastos
def registrar_gasto():
    id_usuario = id_usuario_entry.get()
    gasto_fijo = gasto_fijo_entry.get()
    gasto_diario = gasto_diario_entry.get()
    gasto_hormiga = gasto_hormiga_entry.get()

    if id_usuario and gasto_fijo and gasto_diario and gasto_hormiga:
        conexion = conectar_db()
        if conexion:
            try:
                cursor = conexion.cursor()
                fecha_actual = datetime.date.today()
                query = "INSERT INTO gastos (id_usuario, gasto_fijo, gasto_diario, gasto_hormiga, fecha) VALUES (%s, %s, %s, %s, %s)"
                cursor.execute(query, (id_usuario, gasto_fijo, gasto_diario, gasto_hormiga, fecha_actual))
                conexion.commit()
                messagebox.showinfo("Éxito", "Gasto registrado correctamente")
                limpiar_campos_gasto()
            except mysql.connector.Error as e:
                messagebox.showerror("Error", f"Error al registrar gasto: {e}")
            finally:
                cursor.close()
                conexion.close()
    else:
        messagebox.showwarning("Advertencia", "Por favor, completa todos los campos")

def limpiar_campos_gasto():
    id_usuario_entry.delete(0, tk.END)
    gasto_fijo_entry.delete(0, tk.END)
    gasto_diario_entry.delete(0, tk.END)
    gasto_hormiga_entry.delete(0, tk.END)

# Función para ver historial de gastos
def ver_historial_gastos():
    id_usuario = consulta_id_usuario_entry.get()

    if id_usuario:
        conexion = conectar_db()
        if conexion:
            try:
                cursor = conexion.cursor()
                query = "SELECT gasto_fijo, gasto_diario, gasto_hormiga, fecha FROM gastos WHERE id_usuario = %s"
                cursor.execute(query, (id_usuario,))
                gastos = cursor.fetchall()

                lista_gastos.delete(0, tk.END)  # Limpiar la lista antes de agregar los nuevos datos

                if len(gastos) == 0:
                    messagebox.showinfo("Historial", f"No se encontraron gastos para el usuario con ID {id_usuario}.")
                else:
                    for gasto in gastos:
                        lista_gastos.insert(tk.END, f"Gasto Fijo: {gasto[0]}, Gasto Diario: {gasto[1]}, Gasto Hormiga: {gasto[2]}, Fecha: {gasto[3]}")
            except mysql.connector.Error as e:
                messagebox.showerror("Error", f"Error al obtener el historial de gastos: {e}")
            finally:
                cursor.close()
                conexion.close()
    else:
        messagebox.showwarning("Advertencia", "Por favor, ingresa un ID de usuario válido")

# Ventana principal
root = tk.Tk()
root.title("Sistema de Gestión de Gastos")
root.geometry("500x700")

# Sección para registrar usuarios
tk.Label(root, text="Registro de Usuario", font=("Helvetica", 14)).pack(pady=10)

tk.Label(root, text="Nombre").pack()
nombre_entry = tk.Entry(root)
nombre_entry.pack()

tk.Label(root, text="Apellido").pack()
apellido_entry = tk.Entry(root)
apellido_entry.pack()

tk.Label(root, text="Correo").pack()
correo_entry = tk.Entry(root)
correo_entry.pack()

tk.Label(root, text="Contraseña").pack()
contraseña_entry = tk.Entry(root, show="*")
contraseña_entry.pack()

tk.Button(root, text="Registrar Usuario", command=registrar_usuario).pack(pady=10)

# Sección para registrar gastos
tk.Label(root, text="Registro de Gastos", font=("Helvetica", 14)).pack(pady=10)

tk.Label(root, text="ID Usuario").pack()
id_usuario_entry = tk.Entry(root)
id_usuario_entry.pack()

tk.Label(root, text="Gasto Fijo").pack()
gasto_fijo_entry = tk.Entry(root)
gasto_fijo_entry.pack()

tk.Label(root, text="Gasto Diario").pack()
gasto_diario_entry = tk.Entry(root)
gasto_diario_entry.pack()

tk.Label(root, text="Gasto Hormiga").pack()
gasto_hormiga_entry = tk.Entry(root)
gasto_hormiga_entry.pack()

tk.Button(root, text="Registrar Gasto", command=registrar_gasto).pack(pady=10)

# Sección para consultar gastos
tk.Label(root, text="Consulta de Historial de Gastos", font=("Helvetica", 14)).pack(pady=20)

tk.Label(root, text="ID Usuario").pack()
consulta_id_usuario_entry = tk.Entry(root)
consulta_id_usuario_entry.pack()

tk.Button(root, text="Ver Historial de Gastos", command=ver_historial_gastos).pack(pady=10)

# Lista de gastos
lista_gastos = Listbox(root, width=60, height=10)
lista_gastos.pack(pady=10)

# Agregar un scrollbar a la lista de gastos
scrollbar = Scrollbar(root)
scrollbar.pack(side=tk.RIGHT, fill=tk.Y)

lista_gastos.config(yscrollcommand=scrollbar.set)
scrollbar.config(command=lista_gastos.yview)

# Iniciar la aplicación
root.mainloop()

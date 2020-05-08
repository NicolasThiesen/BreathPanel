from serial import Serial
from serial import serialutil
from serial.tools.list_ports import comports

from datetime import datetime
from time import sleep
from pathlib import Path
import sqlite3

Path("../Data").mkdir(parents=True, exist_ok=True)

connection = sqlite3.connect("../Data/Respirador.db")

cursor = connection.cursor()
cursor.execute("""CREATE TABLE IF NOT EXISTS Dados(
    timestamp int not null primary key,
    nivel_oxigenio float not null,
    reserva_oxigenio float not null,
    respiracao float not null,
    grafico float not null
    )
    """)


serial_port = None

def insert_data(line_list):
    try:
        nivel_oxi = float(list_line[0])
        quant_oxi = float(list_line[1])
        breath = float(list_line[2])
        grath = float(list_line[3])
        print("Inserindo dados...")
        now = datetime.now()
        time_splited = str(datetime.timestamp(now)).split(".")
        current_time = (time_splited[0]+time_splited[1])
        timestamp =  int(current_time)
        cursor.execute(f"INSERT INTO Dados VALUES ({timestamp},{nivel_oxi},{quant_oxi},{breath},{grath})")
        connection.commit()
    except IndexError:
        print("Erro: Falta de dados... Os dados não puderam ser inseridos no banco de dados.") 
    except ValueError:
        print("Erro: Números incorretos... Os valores fornecidos não são do tipo float ou int. Os dados não puderam ser inseridos no banco de dados.")
    except sqlite3.OperationalError:
        print("Erro: O banco de dados está sendo usado, o programa não pode inserir os dados")


while (True):
    while (serial_port == None):
        list_com = comports(include_links=False)
        for com_full in list_com:
            com = com_full.device
            try:
                serial_port = Serial(com)
                print("O programa achou a porta serial. Usando porta: ",com)
            except serialutil.SerialException:
                print("O programa não pode usar a porta: ",com)
    try:
        line = serial_port.readline().decode("utf-8")
        list_line = line.split(",")
        print(line)
        insert_data(list_line)
    except serialutil.SerialException:
        print("Erro: O cabo foi desconectado, favor reconectá-lo!")
        print("Tentando ler novamente as portas...")
        serial_port = None
    else:
        sleep(0.5)
    
    
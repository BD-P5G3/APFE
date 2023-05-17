from faker import Faker
import random

# Cria uma instância do Faker
fake = Faker()

# Lista de departamentos fictícios
departamentos = ["Vendas", "Marketing", "RH", "Finanças", "TI"]

# Gera dados fictícios para preencher a tabela
def generate_fake_data(num_rows):
    data = []
    for _ in range(num_rows):
        nif = fake.random_int(min=100000000, max=999999999)
        nome_proprio = fake.first_name()
        apelido = fake.last_name()
        email = fake.email()
        telefone = fake.phone_number()
        morada = fake.address().replace("\n", ", ")
        genero = random.choice(["M", "F"])
        data.append((nif, nome_proprio, apelido, email, telefone, morada, genero))
    return data

# Cria comandos SQL para inserir os dados na tabela
def generate_sql_insert_commands(data):
    commands = []
    for row in data:
        command = f"({row[0]}, '{row[1]}', '{row[2]}', '{row[3]}', {row[4]}, '{row[5]}', '{row[6]}');"
        commands.append(command)
    return commands

# Número de linhas de dados fictícios a serem geradas
num_rows = 100

# Gera os dados fictícios
fake_data = generate_fake_data(num_rows)

# Gera os comandos SQL para inserir os dados na tabela
sql_commands = generate_sql_insert_commands(fake_data)

# Imprime os comandos SQL gerados
for command in sql_commands:
    print(command)
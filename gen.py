from faker import Faker
import random

# Cria uma instância do Faker
fake = Faker()

choose_client = [
    538915867,
    519748396,
    911847104,
    968080065,
    512717923,
    261741939,
    203754953,
    686181635,
    734602847,
    837254890,
    785986415,
    240158594,
    382530585,
    533916394,
    259104140,
    729979948,
    286352453,
    935071764,
    133260774,
    281480761,
    699437765,
    519439633,
    991972282,
    325274605,
    614465660,
    290596287,
    831844134,
    319379054,
    831568458,
    166958630,
    764629617,
    634147386,
    287944069,
    184424855,
    768050941,
    263085123,
    284071297,
    785888742,
    378861758,
    813991455,
    827204590,
    105109164,
    909990217,
    636788195,
    599871432,
    920004165,
    685452999,
    559873828,
    954574501,
    772427491,
    105442534,
    108247780,
    467079908,
    241123033,
    491113344,
    111356719,
    290770611,
    707260842,
    462815779,
    331559633,
    671561996,
]

choose_service = [
    201101,
    201102,
    201103,
    201104,
    201105,
    201106,
    201107,
    201108,
    201109,
    201110,
    201111,
    201112,
    201113,
    201114,
    201115,
    'NULL'
]

choose_worker = [
    123456789,
    987654321,
    456789123,
    567890321,
    624521804,
    732843512,
    824637036,
    '091543871',
    '071821743',
    834812034,
    741029467,
    912543812,
    134820376,
    202465812,
    367290150,
    461092846,
    531425698,
    698145037,
    710795873,
    858170728,
    976019338,
    '036180144',
    149107584,
    280932739,
    331085045,
    485719621,
    547291946,
    658631739,
    759107401,
    878649173,
    953832401,
]

choose_obra = []

choose_fornecedor = [
    817439603,
    208576294,
    643872905,
    965781420,
    312095648,
]

choose_material = [
    1997001,
    1997002,
    1997003,
    1997004,
    1997005,
    1997006,
    1997007,
    1997008,
    1997009,
    1997010,
    1997011,
    1997012,
    1997013,
    1997014,
    1997015,
]

choose_encomenda = [
    1991001,
    1991002,
    1991003,
    1991004,
    1991005,
    1991006,
    1991007,
    1991008,
    1991009,
    1991010,
    1991011,
    1991012,
    1991013,
    1991014,
    1991015,
    1991016,
    1991017,
    1991018,
    1991019,
    1991020,
]

for i in range(0, 91):
    choose_obra.append(19940000 + i)

# Gera dados fictícios para preencher a tabela
def generate_fake_data(num_rows):
    data = []
    for _ in range(num_rows):
        id_encomenda = random.choice(choose_encomenda)
        id_obra = random.choice(choose_obra)
        data.append((id_obra, id_encomenda))

    return data

# Cria comandos SQL para inserir os dados na tabela
def generate_sql_insert_commands(data):
    commands = []
    for row in data:
        command = f"({row[0]}, {row[1]}),"
        commands.append(command)
    return commands

# Número de linhas de dados fictícios a serem geradas
num_rows = 50

# Gera os dados fictícios
fake_data = generate_fake_data(num_rows)

# Gera os comandos SQL para inserir os dados na tabela
sql_commands = generate_sql_insert_commands(fake_data)

# Imprime os comandos SQL gerados
for command in sql_commands:
    print(command)
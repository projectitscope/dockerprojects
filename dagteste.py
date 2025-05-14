from datetime import datetime
from airflow import DAG
from airflow.operators.python_operator import PythonOperator

# Função que será chamada pela tarefa 1
def tarefa_inicio():
    print("Início")

# Função que será chamada pela tarefa 2
def tarefa_fim():
    print("Fim")

# Definindo a DAG
dag = DAG(
    'minha_primeira_dag',
    description='Uma DAG simples para Airflow',
    schedule_interval='*/1 * * * *',  # A DAG tem intervalo de execução de 1 minuto
    start_date=datetime(2025, 3, 14),
    catchup=False,  # Não executar as execuções anteriores ao start_date
)

# Definindo as tarefas
tarefa_1 = PythonOperator(
    task_id='tarefa_inicio',
    python_callable=tarefa_inicio,
    dag=dag,
)

tarefa_2 = PythonOperator(
    task_id='tarefa_fim',
    python_callable=tarefa_fim,
    dag=dag,
)

# Definindo a ordem de execução
tarefa_1 >> tarefa_2  # A tarefa 'tarefa_1' será executada antes de 'tarefa_2'

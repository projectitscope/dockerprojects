# Tempo de cada estágio
DURATION=120  # duração de cada nível (em segundos)

# Número de ciclos desejados
CYCLES=100

for cycle in $(seq 1 $CYCLES); do
  echo "🔁 Ciclo $cycle iniciado"

  echo "⏫ Subindo carga..."

  # Subida: carga leve → média → pesada
  echo "🔴 Nível 1 - carga leve"
  stress-ng --cpu 2 --cpu-method all -t ${DURATION}s --quiet & wait

  echo "🟠 Nível 2 - carga média"
  stress-ng --cpu 4 --cpu-method all -t ${DURATION}s --quiet & wait

  echo "🔴🔴 Nível 3 - carga pesada"
  stress-ng --cpu 6 --cpu-method all -t ${DURATION}s --quiet & wait

  echo "⏬ Descendo carga..."

  # Descida: carga pesada → média → leve
  echo "🔴🔴 Nível 3 - carga pesada"
  stress-ng --cpu 6 --cpu-method all -t ${DURATION}s --quiet & wait

  echo "🟠 Nível 2 - carga média"
  stress-ng --cpu 4 --cpu-method all -t ${DURATION}s --quiet & wait

  echo "🔴 Nível 1 - carga leve"
  stress-ng --cpu 2 --cpu-method all -t ${DURATION}s --quiet & wait

  echo "✅ Ciclo $cycle concluído. Aguardando antes do próximo..."
  sleep 30
done

echo "🏁 Teste de carga finalizado."

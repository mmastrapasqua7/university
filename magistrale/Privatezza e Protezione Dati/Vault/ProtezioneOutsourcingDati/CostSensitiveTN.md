# Cost-sensitive trust negotiation

Ho 2 parti (client e server) che non si conoscono negoziano la policy di accesso. **trust negotiation**

**trust negotation protocol**. Il rilascio di una credenziale è regolato da una policy che specifica le condizioni richieste per rilasciarla

Ogni credenziale e ogni policy hanno un costo:
- + sensitive credential = + policy cost

**goal**: minimizzare il costo totale delle credenziali, ovvero trovare il cammino minimo per ottenere il servizio desiderato col peso minimo, dove i pesi sono i sensitivity cost di ciascuna credenziale. Somma dei costi delle credenziali

CONTRO:
- focus sulla negoziazione invece che sull'user empowerment
- ragiona solo su credenziali, non su attributi: **non è fine-grained**


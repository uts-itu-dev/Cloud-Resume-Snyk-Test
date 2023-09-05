

let Metric = 0;

function Tick()
{
        if (Metric < 100)
        {
                Metric += 1;
                requestAnimationFrame(Tick);
        }

        document.getElementById("Metric").innerHTML = Metric;
}

Tick();
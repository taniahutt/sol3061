-- Elimina las notas de presentador (::: {.notes}) cuando QUARTO_STRIP_NOTES=1.
-- Se usa al publicar una clase (ver publicar_clase.sh). Sin la variable, no hace nada.
function Div(el)
  if os.getenv("QUARTO_STRIP_NOTES") == "1" and el.classes:includes("notes") then
    return {}
  end
end

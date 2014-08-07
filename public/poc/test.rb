x = []
i = 0
j = 0

while(true) do
  break if i > 15
  x[i] = []
  while(true) do
    if x[i].size >= 17
      j = 0
      break
    end

    if i == 0
      if j == 0
        x[i][j] = rand(16)
      else
        while(true) do
          z = rand(16)
          if x[i][j - 1] != z
            x[i][j] =  z
            break
          end
        end
      end
    elsif i > 0
      if j > 0
        while(true) do
          z = rand(16)
          if x[i][j - 1] != z && x[i - 1][j - 1] != z && x[i-1][j] != z && x[i-1][j+1] != z
            x[i][j] = z
            break
          end
        end
      else
        while(true) do
          z = rand(16)
          if x[i - 1][j] != z && x[i-1][j+1] != z
            x[i][j] = z
            break
          else
            next
          end
        end
      end
    end
    j += 1
  end
  i += 1
end
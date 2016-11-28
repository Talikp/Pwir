-- pak_sort.ads

package  Pak_Sort is

type Wektor is array(Integer range <>) of Float;
-- typ wektora

procedure Put_Wektor(W: in Wektor; Kom: String := "");
-- wypisuje wektor z opcjonalnym komentarzem (Kom)

procedure Losuj_Wektor(W: in out Wektor; Max: Float := 100.0);
-- wypełnia wektor liczbami pseudolosowymi z zakresu 0.0..Max

procedure Sortuj_BB(W: in out Wektor);
-- sortowanie tablicy np. bąbelkowe

procedure Scalaj2(W1, W2: in Wektor; W: in out Wektor);
-- scala i sortuje posortowane wektory W1, W2 do W

end Pak_Sort;
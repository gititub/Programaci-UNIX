
<?php

function print_error($message)
{
   echo "<html>\n";
   echo "<head>\n";
   echo "<title>Catalogo de genes</title>\n";
   echo "<link rel=\"stylesheet\" href=\"css.css\">\n";
   echo "</head>\n";
   echo "<body>\n";
   echo "<h1>Catalogo de genes</h1>\n";
   echo "<table>\n";
   echo "<tr><th>$message</th>\n";
   echo "</table>\n";
   echo "</body>\n";
   echo "</html>\n";
   exit();
}

$specie = $_POST['organism'];
$gene = $_POST['gene'];
if(strlen($gene)==0)
{
  print_error("<p>ups!seems gene name is empty</p>\n");
 }
else
{
$gene = str_replace("", "_", $gene);
$gene = str_replace("\\", "_", $gene);
}
   $enlace = mysqli_connect("localhost","sequera","peces") or print_error ("conection not accessible");
   mysqli_select_db($enlace, "genomas") or print_error ("database not accessible");
 

   $fields = "name,chrom,strand, txStart,txEnd, exonCount,name2";

   if ($specie == 1)
   {
     $result = mysqli_query($enlace,"SELECT $fields FROM refGene WHERE name2 LIKE '%$gene%';");
   }
   if ($specie == 2)
   {
     $result = mysqli_query($enlace,"SELECT $fields FROM refGeneCab WHERE name2 LIKE '%$gene%';");
   }
   if ($specie == 3)
   {
     $result = mysqli_query($enlace,"SELECT $fields FROM refGeneGal WHERE name2 LIKE '%$gene%';");
   }
   if ($specie == 4)
   {
     $result = mysqli_query($enlace,"SELECT $fields FROM refGeneCer WHERE name2 LIKE '%$gene%';");
   }
  

   $items= mysqli_affected_rows($enlace);
   if ($items == 0)
   {
   print_error("ups!Not found");
   }
   else
   {
   $transcripts = $items;

   echo "<html>\n";
   echo "<head>\n";
   echo "<title>Catalogo de genes</title>\n";
   echo "<link rel=\"stylesheet\" href=\"css.css\">\n";
   echo "</head>\n";
   echo "<body>\n";
   echo "<h1>Catalogo de genes</h1>\n";
   echo "<table>\n";
   echo "<tr><th>GEN</th><th>TRANSCRIT</th><th>CROMOS</th><th>BRI</th><th>START</th><th>END</th><th>EXONS</th>\n";

   for ($i=0; $i<$items; $i++)
			 {			 
     
   $row= mysqli_fetch_array($result);

       $name2 = $row["name2"];
       $name = $row["name"];
       $chrom = $row["chrom"];
       $strand = $row["strand"];
       $txStart = $row["txStart"];
       $txEnd = $row["txEnd"];
       $exonCount = $row["exonCount"];


       echo "<tr><td>$name2</td><td>$name</td><td>$chrom</td><td>$strand</td>";
       echo "<td>$txStart</td><td>$txEnd</td><td>$exonCount</td>\n";
			 }



			 echo "</table><br><br>\n";
			 }

			 echo "<h1>Link UCSC</h1>\n";
			 if ($specie==1)
			 {
			 echo "<a href='https://genome-euro.ucsc.edu/cgi-bin/hgTracks?hgsid=265595631_4T4EMyZSagWEj8HfDVNfDbJhKaP1&org=Human&db=hg38&position=$name2&pix=1234'>Clik $name2</a>";
			 }
			 if ($specie==2)
			 {
			 echo "<a href='https://genome-euro.ucsc.edu/cgi-bin/hgTracks?hgsid=265595631_4T4EMyZSagWEj8HfDVNfDbJhKaP1&org=Horse&db=equCab3&position=$name2&pix=1234'>Clik $name2</a>";
			 }
			 if ($specie==3)
			 {
			 echo "<a href='https://genome-euro.ucsc.edu/cgi-bin/hgTracks?hgsid=265596792_G6aLmFWhmil3Za1vZJqwzdM1y1vl&org=Chicken&db=galGal6&position=$name2&pix=1234'>Clik $name2</a>";
			 }
			 if ($specie==4)
			 {
			  echo "<a href='https://genome-euro.ucsc.edu/cgi-bin/hgTracks?hgsid=265595631_4T4EMyZSagWEj8HfDVNfDbJhKaP1&org=S.+cerevisiae&db=sacCer3&position=$name2&pix=1234'>Clik $name2</a>";
			  }
			 echo "</body>\n";
			 echo "</html>\n";
			 
			 
 ?>

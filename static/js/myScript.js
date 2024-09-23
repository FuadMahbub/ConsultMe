$(function(){
    //show image
    $("#id_photo").change(function(){
        readURL(this);
    });

    //datepicker
   

    //Data Table
    $('#requestlistTable').DataTable({
        "lengthMenu":[
            [3,5,10,20,50,-1],
            [3,5,10,20,50,"All"],
        ]
    });

    //show dialog
    $("#myModal").modal();
    
    setTimeout(() => {
        $('.alert').hide('slow');
    }, 3000);
});  
    




function readURL(input)
{
    if(input.files && input.files[0])
    {
        var reader=new FileReader();
        reader.onload=function(e)
        {
            $('.blah') .attr('src',e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
    }

}
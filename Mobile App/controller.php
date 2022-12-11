<?php


class HUCPController{

    public $method;
    protected $conn = null;

    public function __construct($method)
    {
        $this->conn = pg_connect("host=localhost dbname=hu-complaint-portal user=postgres password=12345");
        if(!$this->conn)
        {
            echo "Connection not established";
        }
        else
        {
            $this->method = $method;
        }
        
    }

    public function processRequest()
    {
        if($this->method == 'login')
        {
            $this->VerifyLogin();
        }
        if($this->method == 'verify')
        {
            $this->VerifyId();
        }
        if($this->method == 'reset')
        {
            $this->ResetPass();
        }
    }

    public function VerifyLogin()
    {

        // $email = $_POST["email"];
        // $pass = $_POST["password"];

        $email = "ak05419@st.habib.edu.pk";
        $pass = "12345";

        $e = $p = $sid = $sf = $sl = $sp = $sb = null;

        $result = pg_query($this->conn, "SELECT studentid, studentemail, studentfirstname, studentlastname, studentpassword, programname, batch FROM Student, Program WHERE studentemail = '$email'AND studentpassword = '$pass' AND student_program = programid");
    
        while($row = pg_fetch_row($result)) 
        {
            $sid = $row[0];
            $e = $row[1];
            $sf = $row[2];
            $sl = $row[3];
            $p = $row[4];
            $sp = $row[5];
            $sb = $row[6];
        }

        if($e != $email || $p != $pass)
        {
            $response["message"] = "false";
            echo json_encode($response);
        }
        else
        {
            $response["message"] = "true";
            $response["id"] = $sid;
            $response["fname"] = $sf;
            $response["lname"] = $sl;
            $response["program"] = $sp;
            $response["batch"] = $sb;
            echo json_encode($response);

        }
        pg_close($this->conn);
    }

    public function VerifyId()
    {
        $studentID = $_POST["studentid"];
        $email = $_POST["email"];

        $s = $e = null;

        $result = pg_query($this->conn, "SELECT studentid, studentemail FROM Student WHERE studentid = '$studentID' AND studentemail = '$email'");
        while($row = pg_fetch_row($result)) 
        {
            $s = $row[0];
            $e = $row[1];
        }

        if($s != $studentID || $e != $email)
        {
            $response["message"] = "false"; 
            echo json_encode($response);
        }
        else
        {
            $response["message"] = "true";
            echo json_encode($response);

        }
        pg_close($this->conn);

    }

    public function ResetPass()
    {
        $cpass = $_POST["cpassword"];
        $email = $_POST["email"];
        $sid = $_POST["studentid"];

        $result = pg_query($this->conn, "UPDATE Student SET studentpassword = '$cpass' WHERE studentid = '$sid' AND studentemail = '$email'");
        if (!$result)
        {
            $response["message"] = "false";
            echo json_encode($response);
        }
        else
        {
            $response["message"] = "true";
            echo json_encode($response);
        }
        pg_close($this->conn);    
    }

}



?>
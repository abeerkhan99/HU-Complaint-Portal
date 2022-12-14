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
        if($this->method == 'getprogram')
        {
            $this->GetProgram();
        }
        if($this->method == 'getcomplaint')
        {
            $this->GetComplaints();
        }
        if($this->method == 'getdepartment')
        {
            $this->GetDepartment();
        }
        if($this->method == 'getstatus')
        {
            $this->GetStatus();
        }
        if($this->method == 'updatecomplaint')
        {
            $this->UpdateComplaint();
        }
        if($this->method == 'updateprofile')
        {
            $this->UpdateProfile();
        }
    }

    public function VerifyLogin()
    {

        $email = $_POST["email"];
        $pass = $_POST["password"];

        // $email = "ak05419@st.habib.edu.pk";
        // $pass = "12345";

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

    public function GetProgram()
    {
        $items = [];
        $result = pg_query($this->conn, "SELECT programname FROM Program");
        while($row = pg_fetch_row($result))
        {
            $items[] = $row;
        }
        $response["message"] = $items;

        echo json_encode($response);
    }
    
    public function GetComplaints()
    {
        $id = $_POST["studentid"];
        
        $result = pg_query($this->conn, "SELECT complaintid, complainttitle, complaintcontent, complaintdate, resolvedate, departmentname, statusname FROM Complaint, Department, Status WHERE complaint_studentid = '$id' AND departmentid = complaint_departmentid AND statusid = complaint_status");
        while($row = pg_fetch_row($result))
        {
            $items[] = [$row[0], $row[1], $row[2], $row[3], $row[4], $row[5], $row[6]];
        }
        $response["message"] = $items;
        echo json_encode($response);
    }

    public function GetDepartment()
    {
        $items = [];
        $result = pg_query($this->conn, "SELECT departmentname FROM Department");
        while($row = pg_fetch_row($result))
        {
            $items[] = $row;
        }
        $response["message"] = $items;

        echo json_encode($response);

    }

    public function GetStatus()
    {
        $items = [];
        $result = pg_query($this->conn, "SELECT statusname FROM Status");
        while($row = pg_fetch_row($result))
        {
            $items[] = $row;
        }
        $response["message"] = $items;

        echo json_encode($response);

    }

    public function UpdateComplaint()
    {
        $id = $_POST["id"];
        $title = $_POST["title"];
        $content = $_POST["content"];
        $status = $_POST["status"];

        $get_status_id = pg_query($this->conn, "SELECT statusid FROM status WHERE statusname = '$status'");
        $status_id = pg_fetch_row($get_status_id);

        $result = pg_query($this->conn, "UPDATE Complaint SET complainttitle = '$title' AND complaintcontent = '$content' AND complaintstatus = '$status_id' WHERE complaintid = '$id'");
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

    public function UpdateProfile()
    {
        $id = $_POST["id"];
        $fname = $_POST["fname"];
        $lname = $_POST["lname"];
        $email = $_POST["email"];
        $program = $_POST["program"];
        $batch = $_POST["batch"];
        $pass = $_POST["password"];

        // get program id
        $result = pg_query($this->conn, "SELECT programname from Program WHERE programid = '$program'");
        $get_program_id = pg_fetch_row($result);


        if ($pass == "")
        {
            // update the rest 
            $result = pg_query($this->conn, "UPDATE Student SET studentfirstname = '$fname' AND studentlastname = '$lname' AND studentemail = '$email' AND studentprogram = '$get_program_id' ");
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


        }
        else
        {
            $result = pg_query($this->conn, "UPDATE Student SET studentfirstname = '$fname' AND studentlastname = '$lname' AND studentemail = '$email' AND studentprogram = '$get_program_id' AND studentpassword = '$pass' ");
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
        }
        pg_close($this->conn);


    }

}



?>

package main

// import library
import (
	"context"
	"log"
	"net/http"
	"os/exec"
	"sync"
	"time"
)

// main function
func main() {
	cmd := exec.Command("cmd", "/c", "backend.vbs")
	if erra := cmd.Start(); erra != nil {
		log.Fatal(erra)
	}

	httpServerExitDone := &sync.WaitGroup{}

	httpServerExitDone.Add(1)
	srv := StartHttpServer(httpServerExitDone)

	log.Printf("main: serving for 600 seconds")
	// 600 seconds after, it will shutdown the server
	// if you want to change time, just change this line
	time.Sleep(600 * time.Second)

	// 600 seconds after it will give warning on command line
	log.Printf("main: stopping HTTP server")

	// now we can shutdown the server

	// if we got some problem when it was clossing, it will say that
	if err := srv.Shutdown(context.TODO()); err != nil {
		panic(err) // failure/timeout shutting down the server gracefully
	}

	// wait for goroutine started in startHttpServer() to stop
	cmd.Process.Kill()
	exec.Command("Taskkill", "/im", "python.exe", "/f", "/t").Run() // it will terminate the process
	httpServerExitDone.Wait()
	// if shutdown server action completed, it will say that
	log.Printf("main: done. exiting")
}
func StartHttpServer(wg *sync.WaitGroup) *http.Server {
	// set which port to use
	srv := &http.Server{Addr: ":8080"}
	// set server and call website folder
	http.Handle("/", http.FileServer(http.Dir("./web")))

	go func() {
		defer wg.Done() // let main know we are done cleaning up

		// always returns error. ErrServerClosed on graceful close
		if err := srv.ListenAndServe(); err != http.ErrServerClosed {
			// unexpected error. port in use?
			log.Fatalf("ListenAndServe(): %v", err)
		}
	}()

	// returning reference so caller can call Shutdown()
	return srv
}
